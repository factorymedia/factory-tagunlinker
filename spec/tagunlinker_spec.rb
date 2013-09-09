require 'spec_helper'

describe Factory::Tagunlinker do
  
  # Set the path
  let :example do
     File.expand_path("spec/examples/article.html")
  end
  
  let :faulty_example do
    File.expand_path("spec/examples/faulty.html") 
  end
  
  let :faulty_result do
    "[mpora_video id='AAdi5a2v6854' full='true']

Episode 2 from the Norsemen at Folgefonna follows the spring edit theme in the <a href=\"http://whitelines.com/videos/wltv/fridays-fonna-with-len-jorgensen-viktor-wiberg-and-more.html\">first episode</a> nicely. It seems that the snowboarding talent coming out of Norway, although not a new occurrence, has no bounds at the moment.

The <a href=\"http://whitelines.com/videos/wltv/rk-1-crew-tear-vierli-norway-a-new-one.html\">recent edits</a> from the <a href=\"http://whitelines.com/tag/rk1\">RK1</a> crew especially come to mind and although this edit has more of a lighthearted shred in the sun vibe, the impressive snowboarding comes through strong.

This is highlighted a couple of minutes in by what could potentially be a new double cork! Doubles have been a staple in professional snowboarding for a bit now and while a growing number of riders are dipping three times, its refreshing to see that some are still progressing the two.

<a href=\"http://whitelines.com/videos/wltv/halldor-helgason-stomps-lobster-flip-for-the-first-time-on-film-in-epic-keystone-mini-movie.html\" title target=\"_blank\">Halldor's Lobster flip</a> and <a href=\"http://whitelines.com/tag/hans-mindnich\">Hans Midnich's</a> stylish double with a tailgrab at this years superpark come in the same boat and this 'new' double is pretty crazy.

<a href=\"http://whitelines.com/tag/emil-fossheim\">Emil Fossheim</a> is the man who puts it down - its some sort of double front flip with an extra spin.

Whether or not it's completely new, the end result looks pretty sick. I mean the jump isn't very big yet he manages to keep his style throughout. And while he may scrub the landing a little, given the slushy conditions, I think we can let that slide can't we?"
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
  
  it 'should handle evil files' do
    unlinker = Factory::Tagunlinker.new("postland-theory", "periscoping", "foobar")
    unlinker.file_name = faulty_example
    unlinker.unlink!.should eq faulty_result
  end
  
  it 'should handle evil text' do
    unlinker = Factory::Tagunlinker.new("postland-theory", "periscoping", "foobar")
    unlinker.text = File.open(faulty_example).readlines
    unlinker.unlink!.should eq faulty_result
  end
  
  it 'should handle tables' do
    unlinker = Factory::Tagunlinker.new("postland-theory", "periscoping", "foobar")
    unlinker.text = File.open(File.expand_path("spec/examples/table.html")).readlines
    #unlinker.unlink!.should eq "fail"
    unlinker.parse
    output = unlinker.unlink!
    output.should_not eq ""
    puts output
    #unlinker.errors.should == []
    
  end
  
end