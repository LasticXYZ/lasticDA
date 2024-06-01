import "../src/LiqMantleEigen.sol";
import "../src/OracleMock.sol";

contract LiqMantleEigen {
    liqMantleEigen LiqMantleEigen;
    oracleMock OracleMock;
    const admin = accounts[0];
    const user1 = accounts[1];
    const user2 = accounts[2];

    beforeEach(async () => {
        oracleMock = await OracleMock.new();
        liqMantleEigen = await LiqMantleEigen.new(oracleMock.address);
    });

    describe('Deployment', () => {
        it('sets the admin correctly', async () => {
            const retrievedAdmin = await liqMantleEigen.admin();
            assert.equal(retrievedAdmin, admin, "Admin should be the deployer");
        });
    });

    describe('User registration and token distribution', () => {
        beforeEach(async () => {
            await oracleMock.setContribution(user1, 100); // Assuming this is a function in OracleMock
            await oracleMock.setContribution(user2, 200);
            await liqMantleEigen.registerUser({from: user1});
            await liqMantleEigen.registerUser({from: user2});
        });

        it('registers users and fetches contributions correctly', async () => {
            const contribution = await liqMantleEigen.userContributions(user1);
            assert.equal(contribution.toNumber(), 100, "Contribution should match oracle data");
        });

        it('distributes tokens correctly based on contributions', async () => {
            await liqMantleEigen.mintAndDistributeTokens({from: admin});
            const balanceUser1 = await liqMantleEigen.balanceOf(user1);
            const balanceUser2 = await liqMantleEigen.balanceOf(user2);
            assert.isTrue(balanceUser1.toNumber() < balanceUser2.toNumber(), "User2 should receive more tokens than User1");
        });

        it('prevents non-admin from distributing tokens', async () => {
            try {
                await liqMantleEigen.mintAndDistributeTokens({from: user1});
                assert.fail("Should have thrown an error");
            } catch (error) {
                assert.include(error.message, "revert", "Should revert with 'Only admin can distribute tokens'");
            }
        });
    });
});
