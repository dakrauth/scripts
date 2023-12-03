from pprint import pprint
from fabric import task
from invoke import Collection

from . import sites


@task
def status(ctx):
    print(isinstance(sys.modules[__name__], ModuleType))
    # c = connection()
    # c.sudo('whoami', hide='stderr')
    # with c.cd("/www/hq"):
    #     c.run("git status")
    print(ctx.__class__.__name__)
    pprint(vars(ctx))
    ctx.run("uname -n")


ns = Collection()
loc = Collection("local")
loc.add_task(status)
ns.add_collection(loc)

ns.add_collection(sites, name="remote")
