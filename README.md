# Circle CI Rspec debug

For debugging leaky specs in a Circle CI container

## Prequisites

This is a Ruby script for outputting an Rspec command from a Circle CI XML artifact. If none of those things mean anything to you, you're probably not going to find this very useful.

## Instruction for use

1. Clone this repo into which folder you do things with Github r.epos.
2. `cd` into the repo and run `bundle install`
3. Download your Circle CI XML into the `xml/` folder.
4. Amend the `debug.rb` script to point to your XML file.
5. Amend the `debug.rb` script to assign the failure local variable to a stringy representation of the test that is failing. For example, if your `app/models/pizza_spec.rb` file is failing intermittently, make this `failure` variable `"pizza_spec"`.
6. Run the script from your command line with `ruby debug.rb`.
7. This should print out the rspec command you need to run in order to recreate what Circle CI did.
8. Hopefully your flakey spec will now fail locally.
9. If it does, you can play with the script to create a _divide and conquer_ approach to finding what preceding spec causes your `pizza_spec.rb` to fail.
10. Once you can reproduce the failure locally with two tests together, you can fix your flakey spec and make your life a tiny bit better.
