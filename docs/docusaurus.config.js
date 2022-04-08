/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "D2Touch (DHIS2 Flutter SDK)",
  url: "https://udsm-dhis2-lab.github.io",
  baseUrl: "/d2-touch/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  organizationName: "udsm-dhis2-lab",
  projectName: "d2-touch",
  themeConfig: {
    navbar: {
      title: "D2Touch (DHIS2 Flutter SDK)",
      logo: {
        alt: "D2Touch (DHIS2 Flutter SDK)",
        src: "img/logo.svg",
      },
      items: [
        {
          to: "docs/",
          activeBasePath: "docs",
          label: "Docs",
          position: "left",
        },
        {
          href: "https://github.com/udsm-dhis2-lab/d2-touch/tree/develop/docs/",
          label: "GitHub",
          position: "right",
        },
      ],
    },
    footer: {
      style: "dark",
      links: [],
      copyright: `Copyright © ${new Date().getFullYear()} Interactive Apps Space.`,
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          editUrl:
            "https://github.com/udsm-dhis2-lab/d2-touch/edit/develop/docs/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
};
