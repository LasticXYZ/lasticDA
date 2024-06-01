'use client'

import { useAccount, useConnect, useDisconnect } from 'wagmi'

function App() {
  const account = useAccount()
  const { connectors, connect, status, error } = useConnect()
  const { disconnect } = useDisconnect()

  return (
    <>
      <div>
        <h2>Account</h2>

        <div>
          status: {account.status}
          <br />
          addresses: {JSON.stringify(account.addresses)}
          <br />
          chainId: {account.chainId}
        </div>

        {account.status === 'connected' && (
          <button type="button" onClick={() => disconnect()}>
            Disconnect
          </button>
        )}
      </div>

      <div>
        <h2>Connect</h2>
        {connectors.map((connector) => (
          <button
            key={connector.uid}
            onClick={() => connect({ connector })}
            type="button"
          >
            {connector.name}
          </button>
        ))}
        <div>{status}</div>
        <div>{error?.message}</div>
      </div>


      <div className="p-4 max-w-4xl mx-auto">
        <h1 className="text-2xl font-bold text-center">EigenDA Project Details</h1>
        <p className="text-center text-lg mt-4">Here you will find details about the EigenDA project and related projects.</p>
        <ul className="list-disc list-inside">
          <li className="text-blue-500">Mantle</li>
          <li className="text-blue-500">PolyHedra</li>
          <li className="text-blue-500">Lagrange</li>
          <li className="text-blue-500">WitnessChain</li>
          <li className="text-blue-500">EspressoSystems</li>
        </ul>
      </div>
    </>
  )
}

export default App
