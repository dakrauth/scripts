import sys
import getpass
from pprint import pprint
from types import ModuleType
import fabric
from fabric import Connection, Config, task
from invoke import Collection


def connection():
    sudo_pass = getpass.getpass("What's your sudo password?") if 1 else ""
    config = Config(overrides={'sudo': {'password': sudo_pass}})
    return Connection('dak', config=config)


class Task(fabric.Task):

    def __init__(self, *args, **kwargs):
        super(Task, self).__init__(*args, **kwargs)

    def __call__(self, ctx, *args, **kwargs):
        conn = connection()
        return super().__call__(conn, *args, **kwargs)


def remote(*args, **kwargs):
    # Override klass to be our own Task, not Invoke's, unless somebody gave it
    # explicitly.
    kwargs.setdefault("klass", Task)
    kwargs.setdefault("hosts", ["dak"])
    return fabric.task(*args, **kwargs)


@remote
def status(ctx):
    import ipdb; ipdb.set_trace()
    ctx.config.hello
    ctx.run("uname -n")


@remote
def check(ctx):
    ctx.sudo("su - deploy")
    ctx.run("whoami")


@remote
def dbdump(ctx):
    cmd = "mysqldump --default-character-set=utf8mb4 ff | gzip > bak/ff.sql.gz"
    r = ctx.run(cmd, hide="out")
    print(r.ok)
    ctx.local("ls -l ~/dev/bak")
