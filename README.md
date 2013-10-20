age-of-saltstack
================

**Age of SaltStack** is turn-based strategic game where you build wonders using ``Salt Stack``.
The first campaign is automated deployment of ``Django`` web applications using ``Git``.

Wonders
-------

The base units are called **wonders**. They can represent single server with several virtual hosts, single server as single host or cloud of servers.

These **wonders** are configured to run common task with specific config or wonder-specific tasks.

The quest
---------

Automatic deployment of django applications with testing on development server (vagrant) and running project specific services (eg. database, cache, ...) on sandbox server (vagrant).

### Chapter I — Local development and testing

- Set up virtual box (**sandbox**) for local services, eg: databases.
- Use development specific settings in your project

Each project has it's own **sandbox**, there's no need in reflecting server
environment.


### Chapter II — Staging environment

- Set up copy of production server.
- Create the same set of Salt states as for production server, differences
   shouldn't be significant.
- Use production settings in your project with more verbose logging.

Staging servers reflects the real environment as close as possible.


### Chapter III — Production environment

- Configure production server using Salt states from Chapter II.
- Pray
