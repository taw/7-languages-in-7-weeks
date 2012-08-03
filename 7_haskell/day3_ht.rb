#!/usr/bin/env ruby

class Monad
  def self.perform(&blk)
    new.instance_eval(&blk)
  end
end

class MaybeMonad < Monad
  def pass(x)
    x
  end
  
  def bind(v)
    if v.nil?
      nil
    else
      yield(v)
    end
  end
end

universe = {
  "alive" => {
    "animals" => {
      "dog" => "fido", "cat" => "cloud",
    },
    "humans" => {
      "adolf" => "hilter", "angela" => "merkel",
    }
  },
  "things" => {
    "distros" => {
      "linux" => "ubuntu", "mac" => "osx",
    },
    "languages" => {
      "python" => "3000", "ruby" => "1.9.3",
    },
  },
}


def htget3(ht, k1, k2, k3)
  MaybeMonad.perform{
    bind(ht[k1]){|a|
      bind(a[k2]){|b|
        bind(b[k3]){|c|
          pass(c)
        }
      }
    }
  }
end

p htget3(universe, "alive", "humans", "adolf")      # "hitler"
p htget3(universe, "alive", "animals", "cat")       # "cloud"
p htget3(universe, "alive", "animals", "horse")     # nil
p htget3(universe, "things", "languages", "perl")   # nil
p htget3(universe, "things", "languages", "python") # "3000"
p htget3(universe, "abstract", "figures", "circle") # nil
