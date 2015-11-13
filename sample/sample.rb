require 'togezo'

togezo = Togezo.init(ARGV[0])
p togezo.fit(Togezo::GAUSSIAN, 4)
p togezo.positives
p togezo.negatives

