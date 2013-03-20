Vagrant MongoDB Docs
====================

Use [Vagrant](http://www.vagrantup.com/) to quickly install the [MongoDB
Documentation Project](http://docs.mongodb.org/manual/) source, making it super
easy to build and contribute.

Getting Started
---------------

Clone this repository, load the virtual machine and log in.

```
% git clone git://github.com/michaeltwofish/vagrant-mongodb-docs.git
% cd vagrant-mongodb-docs
% vagrant up
% vagrant ssh
```

You're now logged in to a virtual machine that has all the pre-requisites for
building the MongoDB documentation installed, as well as a web server to view
the built HTML.

There's a handy symlink in your home directly that will take you directly to
the source files. Now you can go ahead and build the documentation.

```
% make html
```

This will create a directory called `build/master/html`. The web server is
already configured to load files from there. By default, the server is running
on 192.168.10.33, but you can edit the Vagrantfile to put it wherever you want.

See the [build instructions](http://docs.mongodb.org/manual/meta/build/) for
details of everything that's just happened.

Working on Documentation
------------------------

Before you dive in to working on the documentation, you might want to have a
look at the [Practices and
Processes](http://docs.mongodb.org/manual/meta/practices/) and the [Style
Guide](http://docs.mongodb.org/manual/meta/style-guide/).

By default, the manifest clones the official repository. The odds are very
strong, you don't have permission to push there, so you'll want to fork it and
add your fork as a remote. For example, you might want to do something like
this.

```
git remote rename origin upstream
git remote add origin git@github.com:<gituser>/docs.git
```

Of course, you'll have to deal with adding your GitHub key to the virtual
machine and and SSH config you want. The manifest handily mounts the data
directoy so you can easily get that sort of thing onto the virtual machine.

This is terrible! Or even, how can I help?
------------------------------------------

Pull requests, issues or advice are very (very!) welcome.

1. Fork it.
2. Create a branch (`git checkout -b crazy-fixes`)
3. Commit your changes (`git commit -am "Fix the crazy"`)
4. Push to the branch (`git push origin crazy-fixes`)
5. Open a [Pull Request][1]

[1]: http://github.com/michaeltwofish/vagrant-mongodb-docs/pulls

