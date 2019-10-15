# Giving new Life to Legacy Software with Windows Server Containers and Kubernetes

## It's not going anywhere

I've worked in or for large enterprises for most of my career.  Among other sectors, I've worked in healthcare, finance, biotech, and government.  At a few companies there was always that one box.  Maybe it's in a rack, maybe it's under a desk.  Some old computer running a long-abandoned version of an operating system, with a sticky-note reminding anyone who might be curious not to power it off.  At one company it was the in-house support system, built in late 90's PHP.  At another it was a billing management system, that had gone from Microsoft Access to an Access MDB with an ASP classic.  Sometimes it's something even older, with a mixture of COBOL, a SQL Server Database and ASP classic.  I wish I were making that up, but I helped write it.  

These apps aren't going anywhere.  They're mission critical to businessess, and often times they fit if it a'int broke don't fix it model.  There may be a plan to replace them, but we need to get the most out of them that we can in the meantime.  Today we're going bring a dying system closer to DevOps.

## The ASP Classic Application

I had to find a simple ASP classic application for this demo.  I couldn't grab one of my old solutions.  They're owned by companies that are either long gone, or with whom I don't have a relationship.  [So I grabbed this application](https://docs.google.com/spreadsheets/d/1N3laLAYO3XJMSUDPy2-GvrxdPh8XBL290u1Zs2s73eo/edit#gid=900701639) from shortly after the time we all survied Y2K.  It's a simple chat application.  For those of you who have been in the Microsoft development community, you likely remember 4 Guys from Rolla.  I learned a lot of ASP and ASP.NET 1.x from this website.  The last of the original 4 guys left in 2011, but the property has been maintained and the old posts archived.

## Software Development and Deployment in 2000

Let me take you back to software development and deployment in the first couple years of this millennium.  Hardware virutalization was not yet a thing in the enterprise.  We were deploying to real-machines either specifically for our applications or sharing hardware with other applications.  Software generally got thrown over a wall from business unit to business unit, this is still unfortunately the case at a lot of companies.  And most if not all deployments were done by hand, some were even done right from a developer's machine.  [Lean Software Development](https://www.oreilly.com/library/view/lean-software-development/0321150783/) wouldn't land until Mary and Tom Poppendieck's book did in 2003.  [The Manifesto for Agile Software Development](https://agilemanifesto.org/) was something we were all dicussing as it landed in 2001.  Movements like [extreme programming](http://www.extremeprogramming.org/) and [Scrum](https://www.scrum.org/resources/what-is-scrum), were being adopted in forward thinking enterprises as they were products of the late 1990's.

So with that in mind let's start containerizing this mini-monolith and take advantage of Kubernetes new Windows Server Containers to start bring good automation practices to this application.

## Examining the Application

The chat application contains 3 files.
