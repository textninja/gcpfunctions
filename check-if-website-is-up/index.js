const playwright = require('playwright');
const chrome = playwright.chromium;

exports.checkUptime = async (_req, res) => {
  const website = process.env.WEBSITE_TO_CHECK;
  if (!website) {
    res.status(500).send({
      error: "website env var must be set"
    });
  }
  const browser = await chrome.launch();
  const page = await browser.newPage();
  const start = performance.now();
  const response = await page.goto(website);
  const end = performance.now();

  res.status(200).send({
    website: website,
    up: response.status() === 200,
    loadTimeInMilliseconds: end-start
  });
};


// cloud function to update database to allow current ip
