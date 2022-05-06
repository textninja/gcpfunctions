exports.getIp = (req, res) => {
  res.status(200).send({
    ip: req.ip,
  });
};
