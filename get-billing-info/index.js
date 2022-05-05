const billing = require('@google-cloud/billing');
const fs = require('fs').promises;

/*

Unique category.resourceGroup values:
[
  "RAM",
  "CPU",
  "GPU",
  "N1Standard",
  "F1Micro",
  "G1Small"
]

*/

exports.getSkusData = async (req, res) => {
  const relevantSkus = JSON.parse(await fs.readFile('skus.json', 'utf-8'))
    .filter(sku => sku.serviceRegions.includes("us-west1"))
    .filter(sku => sku.category.resourceFamily === 'Compute')
    .filter(sku => ["OnDemand", "Preemptible"].includes(sku.category.usageType))
    .filter(
      sku => ["RAM", "CPU", "N1Standard", "F1Micro", "G1Small"]
                .includes(sku.category.resourceGroup)
    )

  res.status(200).send(relevantSkus);
};

async function refreshSkusData() { 
  const client = new billing.CloudCatalogClient;
  const computeEngineService = 'services/6F81-5844-456A';
  const skusData = (await client.listSkus({ parent: computeEngineService })).shift();
  fs.writeFileSync('skus.json', JSON.stringify(skusData, null, 2));
}
