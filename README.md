# Togezo

This is a gem for getting extreme values on a chart via Gaussian/Pearson.

![togezo](https://github.com/deepneko/togezo/blob/master/img/togezo.gif "togezo")

## Installation

You need to install [fityk](http://fityk.nieto.pl/ "fityk") at first.

    $ apt-get install fityk

Then, please install togezo from rubygems.

    $ gem install togezo

## Usage

Prepare a data file describing x,y coordinates.

    $ cat sample.dat
    0 46.177
    1 46.177
    2 46.168
    3 46.157
    4 46.151
       :
       :

Read the data file.  

    require 'togezo'
    togezo = Togezo.init("sample.dat")

Fit with Gaussian or Pearson. 

    togezo.fit(Togezo::GAUSSIAN, 4) # 4 is the number of times of fitting.

Get extreme values as an array of x,y coordinates. 

    p togezo.peaks     # All peaks
    p togezo.positives # Positive peaks from the median of all data. 
    p togezo.negatives # Negative peaks from the median of all data. 

![peaks](https://github.com/deepneko/togezo/blob/master/img/peaks.png "peaks")

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/deepneko/togezo.

