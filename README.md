# Togezo

This is a gem for getting extreme values on a chart via Gaussian/Pearson.

![togezo](https://github.com/deepneko/togezo/blob/master/togezo.gif "togezo")

## Installation

You need to install [fityk](http://fityk.nieto.pl/ "fityk") at first.

    $ apt-get install fityk

Then, please install togezo from rubygems.

    $ gem install togezo

## Usage

    require 'togezo'
    
    togezo = Togezo.init(ARGV[0])
    togezo.fit(Togezo::GAUSSIAN, 5)
    p togezo.peaks
    p togezo.positives
    p togezo.negatives

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deepneko/togezo.

