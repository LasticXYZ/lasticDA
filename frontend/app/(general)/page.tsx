import Image from "next/image"
import Link from "next/link"
import { FaDiscord, FaGithub } from "react-icons/fa"
import { LuBook } from "react-icons/lu"

import { siteConfig } from "@/config/site"
import { cn } from "@/lib/utils"
import { buttonVariants } from "@/components/ui/button"
import {
  PageHeader,
  PageHeaderCTA,
  PageHeaderDescription,
  PageHeaderHeading,
} from "@/components/layout/page-header"
import { CopyButton } from "@/components/shared/copy-button"
import { ExampleDemos } from "@/components/shared/example-demos"
import TokenSummary from "@/components/blockchain/eigenstake"

export default function HomePage() {
  return (
    <div className="container relative mt-20 px-0">
      <PageHeader className="pb-8">
        <Image
          src="/images.png"
          alt="TurboETH Logo"
          width={200}
          height={80}
          className="h-20 w-40 rounded-2xl"
        />
        <PageHeaderHeading>EigenDA</PageHeaderHeading>
        <PageHeaderDescription>EigenDA is a data availability store made by EigenLabs and built on top of EigenLayer, currently on mainnet since Q2 2024. It is also available on Holesky testnet for testing and development purposes.</PageHeaderDescription>
        <PageHeaderCTA>
          <Link
            href={siteConfig.links.docs}
            target="_blank"
            rel="noreferrer noopener"
            className={buttonVariants({ variant: "default" })}
          >
            <LuBook className="mr-2 h-4 w-4" />
            Docs
          </Link>
          <Link
            href={siteConfig.links.github}
            target="_blank"
            rel="noreferrer noopener"
            className={buttonVariants({ variant: "secondary" })}
          >
            <FaGithub className="mr-2 h-4 w-4" />
            Github
          </Link>
          <Link
            href={siteConfig.links.discord}
            target="_blank"
            rel="noreferrer noopener"
            className={cn(
              buttonVariants(),
              "bg-[#7289da] text-white hover:bg-[#7289da]/80"
            )}
          >
            <FaDiscord className="mr-2 h-4 w-4" />
            Discord
          </Link>
        </PageHeaderCTA>
        {/* <PageHeaderCTA>
          <CopyButton value="pnpm create turbo-eth@latest">
            <span className="text-xs sm:text-base">
              pnpm create turbo-eth@latest
            </span>
          </CopyButton>
        </PageHeaderCTA> */}
      </PageHeader>
      {/* Show how much money eigen token the user has */}
      
      <div className="container mx-auto flex items-center justify-center px-4">
        <TokenSummary totalEigenTokens={100} stakedEigenTokens={50} claimableEigenTokens={25} />
      </div>

      <ExampleDemos />
    </div>
  )
}
