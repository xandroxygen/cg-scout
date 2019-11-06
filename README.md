# cg-scout

> See what's deployed where in a Cloudgate app.

> Note: Cloudgate is an internal app for Instructure software and is only used there.

## Installation

```
git clone <this repo>
cd cg-scout
bundle install
rake install
```

## Usage

`cg-scout` is meant for use with Cloudgate apps, and as such requires that it be ran
in a directory that is a Git repository, contains a Cloudgate app, and that AWS 
credentials are loaded (for an easy way to do that, see [`vaulted`](https://github.com/miquella/vaulted)).

```
cg-scout -h
```

## Why

This is a commonly asked question about Cloudgate apps. `cg-scout` is by no means a robust solution,
but it does provide a little help and a nice wrapper, and is meant to provide a quick glance at what's
currently deployed.

Also, it was a Hackweek project!
