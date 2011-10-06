require 'spec_helper'

describe Photo, 'Metadata' do
  describe 'topfoto_0035386.jpg' do
    before(:all) do
      @photo = Photo.new
      @photo.image = File.open(File.join(Rails.root, 'spec/files',
                                    'topfoto_0035386.jpg'))
    end

    subject { @photo }

    it { should be_valid }
    specify { subject.save.should == true }

    its(:image_original_filename) { should == 'topfoto_0035386.jpg' }
    its(:image_original_secure_token) { should == 'secretOne' }
    its(:image_secure_token) { should == 'secretTwo' }

    its(:title) { should == 'Victoria Plums' }
    its(:description) do
      should == "Victoria Plums\n\n?2000 Credit:Topham Picturepoint\n\nVictoria Plums *** Local Caption *** C00944073"
    end
    its(:author) { should == 'Nicky E' }
    its(:credit) { should == 'TopFoto' }
    its(:taken_at) { should == DateTime.parse('2000/03/07 11:00:00 UTC +00:00')  }
    its(:digitized_at) { should == DateTime.parse('2000/03/07 11:00:00 UTC +00:00') }
    
    its(:copyright) { should == '' }

    # TODO: its(:source) { should == 'Foo' }
  end

  describe 'EP_20061105_mgo_g90_395.jpg' do
    before(:all) do
      @photo = Photo.new
      @photo.image = File.open(File.join(Rails.root, 'spec/files',
                                    'EP_20061105_mgo_g90_395.jpg'))
    end

    subject { @photo }

    it { should be_valid }
    specify { subject.save.should == true }

    its(:image_original_filename) { should == 'EP_20061105_mgo_g90_395.jpg' }
    its(:image_original_secure_token) { should == 'secretOne' }
    its(:image_secure_token) { should == 'secretTwo' }

    its(:title) { should == '1965 - Faster Pussycat Kill Kill - Movie Set' }

    its(:description) do
      should == "1965 - Faster Pussycat Kill Kill - Movie Set\n\nEve Productions\n\nRELEASE DATE: 1965. DIRECTOR: Russ Meyer. STUDIO: Eve Productions. PLOT: Three strippers seeking thrills encounter a young couple in the desert. After dispatching the boyfriend, they take the girl hostage and begin scheming on a crippled old man living with his two sons in the desert, reputedly hiding a tidy sum of cash. ..PICTURED: LORI WILLIAMS (as Billie), HAJI (as Rosie), TURA SATANA (as Varla).  Title Faster Pussycat! Kill! Kill!"
    end

    its(:author) { should == 'Entertainment Pictures' }
    its(:credit) { should == 'Entertainment Pictures' }
    its(:taken_at) { should == DateTime.parse('1965/06/01 11:00:00 UTC +00:00')  }
    its(:digitized_at) { should == DateTime.parse('1965/06/01 11:00:00 UTC +00:00') }

    its(:copyright) { should == "? 1965 by Entertainment Pictures\n\nThis image is NOT available for commercial or promotional use and is being made available for editorial reference usage only." }

    # TODO: its(:source) { should == 'Foo' }

  end
end
