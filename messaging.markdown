Messaging
=========

A few brief examples of what common messaging terms mean, hopefully
using the language introduced by Enterprise Integration Patterns (EIP) so
we have a common vocabulary.

Queue [EIP: Point to Point Channel]
-----------------------------------

Used to load balance work. When a process wants a certain piece of work
done  it should publish it to the queue designated for that purpose.

Every message on a queue is delivered to at most one subscriber to that
queue. If no subscribers are connected the messages will be stored by
the broker.

                                     /-----[2]----{ subscriber }
    {producer}--[4]--{broker}--{queue}
                                     \--[3]--[1]--{ subscriber }

Topic [EIP: Publish Subscribe Channel]
--------------------------------------

Used to indicate interest in something. When a process does something
that may be of interest to one or more other process but doesn't directly
require any work is done on the output it should put this information on
a topic.

Every message on a topic is sent to every non-durable subscriber that is
connected as well as every *durable* subscriber, whether they are
connected at the moment or not (See EIP: Durable Subscriber).

                                     /--[2]--[1]--{ subscriber }
    {producer}--[3]--{broker}--{topic}--[2]--[1]--{ subscriber }
                                     \--[2]--[1]--{ subscriber }
