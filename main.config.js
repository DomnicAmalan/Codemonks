
module.exports = {
  apps: [
    {
      name: 'codemonks',
      script: 'yarn',
      args: 'start',
      watch: true,
      exec_mode: "cluster",
      cwd: "/var/www/codemonks/current/",
      env: {
        "PORT": "3000",
      },
    },
  ],
};
