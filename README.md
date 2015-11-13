# Togezo

This is a gem for getting extreme values on a chart via Gaussian/Pearson.

![togezo](https://github.com/deepneko/togezo/blob/master/togezo.gif "togezo")

## Installation

You need to install [fityk](http://fityk.nieto.pl/ "fityk") at first.

    $ apt-get install fityk

Then, please install togezo from rubygems.

    $ gem install togezo

## Usage

- Prepare a data file describing x,y coordinates.

    $ cat sample.dat
    0 46.177
    1 46.177
    2 46.168
    3 46.157
    4 46.151
       :
       :

- Read the data file.  

    require 'togezo'
    togezo = Togezo.init("sample.dat")

- Fit with Gaussian or Pearson. 

    togezo.fit(Togezo::GAUSSIAN, 5)

- Get extreme values as an array of x,y coordinates. 

    p togezo.peaks
    p togezo.positives
    p togezo.negatives

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deepneko/togezo.

