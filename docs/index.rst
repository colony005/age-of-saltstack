.. Age of SaltStack documentation master file, created by
   sphinx-quickstart on Sun Oct 20 20:40:56 2013.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to Age of SaltStack's documentation!
============================================

Contents:

.. toctree::
   :maxdepth: 2

**Age of SaltStack** is turn-based strategic game where you build wonders using ``SaltStack``.
The first campaign is automated deployment of ``Django`` web applications using ``Git``.

Wonders
-------

The base units are called **wonders**. They can represent single server with several virtual hosts, single server as single host or cloud of servers.

These **wonders** are configured to run common task with specific config or wonder-specific tasks.

The quest
---------

Automatic deployment of django applications with testing on development server (vagrant) and running project specific services (eg. database, cache, ...) on sandbox server (vagrant).

Chapter I — Local development and testing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Set up virtual box (**sandbox**) for local services, eg: databases.
- Use development specific settings in your project

Each project has it's own **sandbox**, there's no need in reflecting server
environment.


Chapter II — Staging environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Set up copy of production server.
- Create the same set of Salt states as for production server, differences
   shouldn't be significant.
- Use production settings in your project with more verbose logging.

Staging servers reflects the real environment as close as possible.


Chapter III — Production environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- Configure production server using Salt states from Chapter II.
- Pray



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

