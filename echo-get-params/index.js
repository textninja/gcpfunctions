exports.echoParams = (req, res) => {
  res.status(200).send(req.query);
};
