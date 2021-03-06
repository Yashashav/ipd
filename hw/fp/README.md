# Final Project

For the final project, you must work alone. Choose one of the two
following options:

1. an ISL implementation of big-bang style game in the spirit of the
   falling game from assignments 2 and 4 or, <!--- haridu -->

2. a C++ implementation of two data structures from the list below
  (unless you choose BWT, in which case that one is sufficient)

If you choose option 1), your proposal must include a high-level
English description of the game (what are the objectives and what
style game is it), it must include at least 7 different features the
game will have, and it must include your best, first guess as to what
the data-definition will be for a `world`. (Note that this will
probably be wrong, but for subtle reasons that you will not discover
until you start working on the implementation of the game.)

If you choose option 2, you must choose two of the following data
structures to implement in C++:

* [splay tree](http://www.cs.cmu.edu/~sleator/papers/self-adjusting.pdf)
  <!--- relic -->

* [treap](http://faculty.washington.edu/aragon/pubs/rst89.pdf)
  <!--- siddharth -->

* [beap](http://www.sciencedirect.com/science/article/pii/0022000080900379)
  <!--- ismael -->

* [min-max heap](http://www.akira.ruc.dk/~keld/teaching/algoritmedesign_f03/Artikler/02/Atkinson86.pdf)
  <!--- sangrin -->

* [B-tree](http://people.cs.aau.dk/~simas/aalg06/UbiquitBtree.pdf)
  <!--- siddharth -->

* [Fibonacci heap](https://www.cs.princeton.edu/courses/archive/fall03/cs528/handouts/fibonacci%20heaps.pdf)
  <!--- relic -->

* [rope](http://citeseer.ist.psu.edu/viewdoc/download?doi=10.1.1.14.9450&rep=rep1&type=pdf)
  <!--- michael -->

* [suffix trie](http://airelles.i3s.unice.fr/files/Weiner.pdf)
  <!--- sangrin -->

* [robin-hood hashing](https://cs.uwaterloo.ca/research/tr/1986/CS-86-14.pdf)
  <!--- michael -->

* [suffix array](http://webglimpse.net/pubs/suffix.pdf)
  <!--- ismael -->

* [karatsuba multiplication on arbitrarily sized integers](https://en.wikipedia.org/wiki/Karatsuba_algorithm)
  <!--- yibing -->

* [topological sort](https://en.wikipedia.org/wiki/Topological_sorting)
  <!--- yibing -->

Or, you may choose to implement the [Burrows-Wheeler
transform](https://en.wikipedia.org/wiki/Burrows%E2%80%93Wheeler_transform)
as an extenion to your compression project. (No second data structure is required in this case.)

For your proposal, you must provide C++ class definitions, a
description of the ADT (like we showed in class), and a few test cases
(that will fail) that describe how the data structure works.

For the C++ choice, no two students may choose the same data
structures. Post your choices in Piazza; first come, first served.

## Final Project Presentations

### C++ Option

Prepare PDF slideshows (like with Keynote or PowerPoint) to present your
data structures. The outline for each is as follows:

1. Purpose—What is the data structure for, and how does it compare to
   similar data structures? Why would we choose this data structure over
   one of the alternatives? This should be explained at a high level.
   (For example, if your data structure were a binary heap, you would
   explain that it implements the priority queue ADT compactly and
   efficiently. with log-time insertion and removal.)

2. Concept—Explain conceptually how the data structure works, probably
   with pictures; what are the invariants? (For example, if your data
   structure were a binary heap, you would show how the heap is
   represented as a complete tree flattened into an array, and you would
   explain the heap property that parents are no greater than children.
   Then describe how bubbling up and percolating down restore the
   invariant.)

3. API—How is the data structure used? Show the list of interface
   functions and their purposes, and give an example of client code that
   uses it.

4. Implementation—Show us 2–3 interesting parts of the implementation.
   One part should be the private member variables, where you explain
   how your concrete representation in C++ corresponds to the abstract
   description from part 2. We probably don’t want to see more than
   three slides of code. (For example, for a binary heap you would show
   the private members, and then maybe the percolate-down procedure.)

5. Questions from the audience. Be prepared to show and explain any of
   your code.

We may not get through both of your data structures. When it’s your
turn, we will decide which data structure you should present first. If
you don’t finish presenting the second data structure, that’s
okay—we’ll still grade your slides and code.  

### ISL Game Option

Prepare a PDF slideshow (like with Keynote or PowerPoint) to present
your game. The outline is as follows:

1. Describe the concept behind your game and the rules. Show us some key
   screenshots. List features/rules.

2. Demo the game by running it in DrRacket. (I will have it ready to run
   on my computer.) Try to demonstrate as many features as possible.
   [This part obviously won’t be in your slides.]

3. Explain the data definition for your world. How does it correspond to
   the game as the player sees it?

4. Show us 1–2 interesting parts of the code.

5. Questions from the audience. Be prepared to show and explain any of
   your code.
