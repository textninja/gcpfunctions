const gcpMetadata = require('gcp-metadata');
const ResourceManager = require('@google-cloud/resource-manager');

exports.selfdestruct = async (req, res) => {
  const projectId = await gcpMetadata.project('project-id');
  const projectToDelete = req.query.projectToDelete
    || req.body.projectToDelete
    || '';
  if (projectId && projectToDelete === projectId) {
    const client = new ResourceManager.ProjectsClient;
    await client.deleteProject({
      name: `projects/${projectId}`
    });
    res.status(200).send({
      project: projectId,
      deleted: true
    });
  } else {
    res.status(400).send({
      project: projectId,
      projectToDelete,
      deleted: false
    });
  }
};
