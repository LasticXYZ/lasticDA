// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Site
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
interface SiteConfig {
  name: string
  title: string
  emoji: string
  description: string
  localeDefault: string
  links: {
    docs: string
    discord: string
    twitter: string
    github: string
  }
}

export const SITE_CANONICAL = "https://lastic.xyz"

export const siteConfig: SiteConfig = {
  name: "Lastic",
  title: "Lastic - DA Marketplace",
  emoji: "🍭",
  description:
    "Data availability Marketplace for Ethereum Layer 2. Lastic is a decentralized marketplace for data availability services on Ethereum Layer 2.",
  localeDefault: "en",
  links: {
    docs: "https://docs.eigenlayer.xyz/",
    discord: "https://discord.com/invite/eigenlayer",
    twitter: "https://x.com/eigenlayer",
    github: "https://github.com/Layr-Labs",
  },
}

export const DEPLOY_URL =
  "https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fturbo-eth%2Ftemplate-web3-app&project-name=TurboETH&repository-name=turbo-eth&demo-title=TurboETH&env=NEXTAUTH_SECRET,DATABASE_URL&envDescription=How%20to%20get%20these%20env%20variables%3A&envLink=https%3A%2F%2Fgithub.com%2Fturbo-eth%2Ftemplate-web3-app%2Fblob%2Fintegrations%2F.env.example"
