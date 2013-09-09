require 'spec_helper'

describe Factory::Tagunlinker do
  
  # Set the path
  let :example do
     File.expand_path("spec/examples/article.html")
  end
  
  # Don't edit the formatting!
  let :result do
    "[mpora_video id='AAdis8p2zj11' full='true']

Postland Theory <a href=\"http://whitelines.mpora.com/tag/postland-theory-brains\">Postland Theory Brains</a> have definitely been busy this year, with filming for Periscoping, and setting up the Rail Riots competition so we think it's fair that they can have some down time. However it looks like Dachstein had a different agenda, pulling over a blanket of fog for their three days of holiday.

As it turns out, this didn't stop them at all. So the guys popped out this little edit of the lot of them shredding whatever they could still see. Seriously, it looks like you would need the eyes of a hawk to spot anything in those conditions, however it hardly looks like it fazes Postland. Enjoy..."
  end
  
  it 'should unlink tags from a file' do
    unlinker = Factory::Tagunlinker.new("postland-theory", "periscoping", "foobar")
    unlinker.file_name = example
    unlinker.unlink!.should eq result
  end
  
  it 'should unlink tags from  a string' do
    unlinker = Factory::Tagunlinker.new("postland-theory", "periscoping", "foobar")
    unlinker.text = File.open(example).readlines
    unlinker.unlink!.should eq result
  end
  
end