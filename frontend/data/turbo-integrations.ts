export const integrationCategories = [
  "general",
  "protocols",
  "services",
] as const

interface TurboIntegration {
  name: string
  href: string
  url: string
  description: string
  imgLight: string
  imgDark: string
  category: (typeof integrationCategories)[number]
}

export const eigenIntegrations = {
    mantle: {
      name: "Mantle",
      href: "/projects/mantle",
      url: "https://mantle.xyz/",
      description: "Mantle provides infrastructure services for decentralized applications, aiming to simplify blockchain interactions.",
      imgLight: "/projects/mantle.svg",
      imgDark: "/projects/mantle-dark.svg",
      category: "infrastructure",
    },
    starter: {
      name: "Mantle",
      href: "/projects/mantle",
      url: "https://mantle.xyz/",
      description: "Mantle provides infrastructure services for decentralized applications, aiming to simplify blockchain interactions.",
      imgLight: "/projects/mantle.svg",
      imgDark: "/projects/mantle-dark.svg",
      category: "infrastructure",
    },
    polyHedra: {
      name: "PolyHedra",
      href: "/projects/polyhedra",
      url: "https://polyhedra.xyz/",
      description: "PolyHedra offers tools for complex geometric computations on the blockchain, enabling new types of digital assets.",
      imgLight: "/projects/polyhedra.svg",
      imgDark: "/projects/polyhedra-dark.svg",
      category: "tools",
    },
    lagrange: {
      name: "Lagrange",
      href: "/projects/lagrange",
      url: "https://lagrange.xyz/",
      description: "Lagrange is a decentralized finance platform focused on creating stable, efficient financial instruments.",
      imgLight: "/projects/lagrange.svg",
      imgDark: "/projects/lagrange-dark.svg",
      category: "finance",
    },
    witnessChain: {
      name: "WitnessChain",
      href: "/projects/witnesschain",
      url: "https://witnesschain.xyz/",
      description: "WitnessChain provides a blockchain-based solution for transparent and tamper-proof notarial services.",
      imgLight: "/projects/witnesschain.svg",
      imgDark: "/projects/witnesschain-dark.svg",
      category: "security",
    },
    espressoSystems: {
      name: "Espresso Systems",
      href: "/projects/espressosystems",
      url: "https://espressosystems.xyz/",
      description: "Espresso Systems is developing a new layer for enhancing privacy and scalability in blockchain ecosystems.",
      imgLight: "/projects/espressosystems.svg",
      imgDark: "/projects/espressosystems-dark.svg",
      category: "privacy",
    }
} as const
