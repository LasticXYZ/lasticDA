"use client"

import Image from "next/image"
import Link from "next/link"
import { eigenIntegrations } from "@/data/turbo-integrations"
import { motion, MotionProps } from "framer-motion"
import ReactMarkdown from "react-markdown"
import Balancer from "react-wrap-balancer"
import { cn } from "@/lib/utils"
import { fadeUpVariant } from "@/lib/utils/motion"
import { buttonVariants } from "@/components/ui/button"
import { PageSectionGrid } from "@/components/layout/page-section"

const demos = [
  {
    title: eigenIntegrations.mantle.name,
    description: eigenIntegrations.mantle.description,
    href: eigenIntegrations.mantle.href,
    demo: (
      <div className="flex items-center justify-center space-x-20">
        <Image
          alt="Disco logo"
          className="rounded-full"
          height={100}
          src="/integrations/mantle.png"
          width={100}
        />
      </div>
    ),
  },
  {
    title: eigenIntegrations.polyHedra.name,
    description: eigenIntegrations.polyHedra.description,
    href: eigenIntegrations.polyHedra.href,
    demo: (
      <div className="flex items-center justify-center space-x-20">
        <Image
          alt="Disco logo"
          className="rounded-full"
          height={100}
          src="/integrations/discoDark.png"
          width={100}
        />
      </div>
    ),
  },
  {
    title: eigenIntegrations.lagrange.name,
    description: eigenIntegrations.lagrange.description,
    href: eigenIntegrations.lagrange.href,
    demo: (
      <div className="flex items-center justify-center space-x-20">
        <Image
          alt="Disco logo"
          className="rounded-full"
          height={100}
          src="/integrations/discoDark.png"
          width={100}
        />
      </div>
    ),
  },
  {
    title: eigenIntegrations.witnessChain.name,
    description: eigenIntegrations.witnessChain.description,
    href: eigenIntegrations.witnessChain.href,
    demo: (
      <div className="flex items-center justify-center space-x-20">
        <Image
          alt="Disco logo"
          className="rounded-full"
          height={100}
          src="/integrations/discoDark.png"
          width={100}
        />
      </div>
    ),
  },
  {
    title: eigenIntegrations.espressoSystems.name,
    description: eigenIntegrations.espressoSystems.description,
    href: eigenIntegrations.espressoSystems.href,
    demo: (
      <div className="flex items-center justify-center space-x-20">
        <Image
          alt="Disco logo"
          className="rounded-full"
          height={100}
          src="/integrations/discoDark.png"
          width={100}
        />
      </div>
    ),
  },

]

interface ExampleDemosProps extends MotionProps {
  className?: string
}

export function ExampleDemos({ className, ...props }: ExampleDemosProps) {
  return (
    <div className="flex items-center justify-center">
      <PageSectionGrid className={className} {...props}>
        {demos.map(({ title, description, href, demo }) => (
          <DemoCard
            key={title}
            title={title}
            description={description}
            href={href}
            demo={demo}
          />
        ))}
      </PageSectionGrid>
    </div>
  )
}

interface DemoCardProps extends MotionProps {
  demo: React.ReactNode
  title: string
  description: string
  href?: string
}

function DemoCard({ title, description, href, demo }: DemoCardProps) {
  return (
    <motion.div
      variants={fadeUpVariant()}
      className={`relative col-span-1 overflow-hidden rounded-xl border px-4 shadow-sm transition-shadow hover:shadow-md`}
      key={title} 
    >
      <div className="flex h-60 items-center justify-center">{demo}</div>
      <div className="mx-auto my-5 max-w-xl text-center">
        <h2 className="mb-5 bg-gradient-to-br from-black to-stone-500 bg-clip-text text-xl font-bold text-transparent dark:from-stone-100 dark:to-emerald-200 md:text-3xl md:font-normal">
          <Balancer>{title}</Balancer>
        </h2>
        <div className="prose-sm md:prose -mt-2 leading-normal">
          <Balancer>
            <ReactMarkdown
              components={{
                a: ({ ...props }) => (
                  <a
                    rel="noopener noreferrer"
                    target="_blank"
                    {...props}
                    className="font-medium underline transition-colors dark:text-blue-200"
                  />
                ),

                code: ({ ...props }) => (
                  <code
                    {...props}
                    className="rounded-sm px-1 py-0.5 font-mono font-medium"
                  />
                ),
              }}
            >
              {description}
            </ReactMarkdown>
            <div className="my-5">
              <div className="mt-2 flex items-center justify-between">
                <span>Allocation Bonus:</span>
                <span className="font-bold">5%</span>
              </div>
              <div className="mt-2 flex items-center justify-between">
                <span>Commission:</span>
                <span className="font-bold">20%</span>
              </div>

            </div>
          </Balancer>
        </div>
        {!href ? null : (
          <Link href={href} className={cn(buttonVariants(), "my-4")}>
            Stake
          </Link>
        )}
      </div>
    </motion.div>
  )
}
