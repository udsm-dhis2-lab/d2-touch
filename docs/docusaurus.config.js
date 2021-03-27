/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "DHIS2 Flutter SDK",
  url: "https://interactive-apps.github.io",
  baseUrl: "/dhis2-flutter-sdk",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/favicon.ico",
  organizationName: "interactive-apps",
  projectName: "dhis2-flutter-sdk",
  themeConfig: {
    navbar: {
      title: "DHIS2 Flutter SDK",
      logo: {
        alt: "DHIS2 Flutter SDK",
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
          href:
            "https://github.com/interactive-apps/dhis2-flutter-sdk/tree/develop/docs/",
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
            "https://github.com/interactive-apps/dhis2-flutter-sdk/edit/develop/docs/",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
};
