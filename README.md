= Quincunx
== A ridiculous Gem that brings Erlang style pattern-matching to Ruby

One of the things I love the most about functional programming, and that I miss having in Ruby, is pattern matching. The ability to both assert on the content and structure of a variable while also ‘de-structuring’ it - pulling it apart to get out the bits you’re interested in - is both phenomenally cool and phenomenally powerful.

In the most exciting languages, you can push up pattern matching to the level of function dispatch, defining several versions of a function that match particular patterns of arguments, and again, extracting the bits you’re interested in at the same time. ML is one such language; Erlang is another.

So, given that Ruby allows you to make some pretty nice DSLs, I thought I’d have a go at implementing Erlang style pattern-matching in Ruby! A ridiculous idea you might think - and I would tend to agree - but it just about works. The result is called Quincunx, which I’ve named after the pattern (geddit?) made by the banana trees in the plantation in one of my favourite ever novels, Jealousy by Alain Robbe-Grillet (If you haven’t read it, read it! It is unlike any other writing I have ever come across). It’s also available on rubygems.

Let’s have a look at how it works by making a Bar.

For starters, let’s assume we have a bunch of simple model classes like these:

    class Drink; end
    class SoftDrink < Drink; end
    class AlcoholicDrink < Drink; end

    class Lemonade < SoftDrink; end
    class WhiskeySour < AlcoholicDrink; end

    Person = Struct.new(:name, :age)

You include Quincunx as a module in any classes you want to use it in, like this:

    class Bar
      include Quincunx
      
Then, instead of using def to define instance methods, you use define. But define works in a slightly different way than you’re used to. Let’s look at a simple example: anyone, without restriction, should be able to order a soft-drink from the Bar.

    define :serve, [Person, keys: [:name]], SoftDrink do
      puts "A soft drink, #{name}? No problem."
    end
    
It’s definitely got the ugliness of Erlang, hasn’t it?

But let me take a minute to explain what’s going on here. We are defining a method on Bar called serve. This method takes two arguments.

Although the arguments are not given names here, they could be. We’ll see how to do that later, but we’re not interested in them as whole objects for now so there’s no need.

The first argument must be a Person - that’s the first part of the match - and it must have a name field. You can see, too, how the name field is extracted when calling the method such that it can be used in the body.

If we didn’t want to restrict ourselves to instances of Person or a subclass, we could have specified Anything instead. This would have matched any object with a name field.

The second argument simply matches any SoftDrink.

So we can now call the serve method like this:

    bar = Bar.new
    adult = Person.new("Russell", 29)
    child = Person.new("Fiona", 12)
    lemonade = Lemonade.new

    bar.serve(adult, lemonade) # => "A soft drink, Russell? No problem."
    bar.serve(child, lemonade) # => "A soft drink, Fiona? No problem."
    
If serve is called with any arguments that don’t match the pattern here, method_missing is triggered.

This next part is where it gets interesting.

We can use define to define multiple versions of the same method. So we can also deal with making sure we don’t serve any alcoholic drinks to children!

    define :serve,
      [Person, keys: [:name, :age]],
      AlcoholicDrink,
      when: ->{ age < 18 } do

      puts "No chance, #{name}, you're only #{age}!"
    end
    
Just as in the first example, we define the first argument to be a Person and we extract their name, but also, this time, their age.

This time, for the second argument, we match AlcoholicDrinks (these matches are made using === by the way, so anything you’d use in a case statement will work here, including Procs).

And finally, there’s a new concept here, too - a guard. The last line of the method signature when: -> { age < 18 } ensures that this version of the method will only be matched when passed a Person under 18 years of age. So now the client code looks like this:

    sours = WhiskeySour.new
    bar.serve(child, sours) # => "No chance, Fiona, you're only 12!"
    bar.serve(adult, sours) # => triggers `method_missing`
    
We clearly need to define the behaviour of serve for adults buying alcoholic drinks too. Let’s do that like this, looking at one more feature as we do:

    define :serve,
      [Person, keys: [:name, :age]],
      [Alcopop, as: :drink],
      when: -> { age >= 18 } do

      puts "Here you go, #{name}, here's your #{drink.class}"
    end
    
This is very similar to the previous version, except we’re matching on >= 18 instead of less than. There’s also one other thing - we’re binding the entire second argument to a variable in the method body called drink using the as: :drink syntax in the second match clause. This allows us to call drink.class in the method body (of course, we could have just extracted the class using keys, but for the sake of example…).

Now I can finally have the drink I want.

    bar.serve(adult, sours) # => “Here you go, Russell, here’s your WhiskeySour.”

So, to recap, here’s the full code of the Bar class we’ve created:

    class Bar
      include Quincunx

      define :serve, [Person, keys: [:name]], SoftDrink do
        puts "A soft drink, #{name}? No problem."
      end

      define :serve,
        [Person, keys: [:name, :age]],
        AlcoholicDrink,
        when: ->{ age < 18 } do

        puts "No chance, #{name}, you're only #{age}!"
      end

      define :serve,
        [Person, keys: [:name, :age]],
        [Alcopop, as: :drink],
        when: -> { age >= 18 } do

        puts "Here you go, #{name}, here's your #{drink.class}"
      end

    end

Now, I hope it’s clear that I really, really don’t recommend this gem for use in production. It would be hopelessly slow, and at the end of the day it is just plain ridiculous. However, languages and the differences between them I find endlessly fascinating, and I like to learn as much as I can about as many of them as possible. And trying to implement a cool feature of one language in another is as good a way as any to learn about both of them! Also, it’s just nice to know that if you really, really want to, Ruby will let you do a lot of crazy stuff.
