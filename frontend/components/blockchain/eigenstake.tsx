import { cn } from '@/lib/utils';
import Link from 'next/link';
import React from 'react';
import { buttonVariants } from "@/components/ui/button"

interface TokenSummaryProps {
  totalEigenTokens: number;
  stakedEigenTokens: number;
  claimableEigenTokens: number;
}

const TokenSummary: React.FC<TokenSummaryProps> = ({
  totalEigenTokens,
  stakedEigenTokens,
  claimableEigenTokens,
}) => {
  return (
    <div className="relative col-span-1 max-w-2xl overflow-hidden rounded-xl border p-10 shadow-sm transition-shadow hover:shadow-md ">
      <h2 className="text-center text-lg font-semibold text-gray-700 dark:text-gray-200">Your Eigen Token Summary</h2>
      <div className="mt-4  text-gray-500 dark:text-gray-500">
        <div className="flex items-center justify-between">
          <span>Total EIGEN:</span>
          <span className="font-bold">{totalEigenTokens}</span>
        </div>
        <div className="mt-2 flex items-center justify-between">
          <span>Staked EIGEN:</span>
          <span className="font-bold">{stakedEigenTokens}</span>
        </div>
        <div className="mt-2 flex items-center justify-between">
          <span>Claimable EIGEN:</span>
          <span className="font-bold">{claimableEigenTokens}</span>
        </div>
      </div>
      <div className='mt-5 flex items-center justify-center'>
        <Link href="/" className={cn(buttonVariants(), "")}>
            Claim Rewards
        </Link>
      </div>
    </div>
  );
};

export default TokenSummary;
