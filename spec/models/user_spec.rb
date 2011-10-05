# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  # TODO: it { should ensure_length_of(:first_name).is_at_least(1).is_at_most(20) }
  # TODO: it { should ensure_length_of(:last_name).is_at_least(1).is_at_most(20) }

  it { should validate_presence_of(:email) }
  # TODO: it { should ensure_length_of(:email).is_at_least(6).is_at_most(100) }


  describe "factory" do
    subject { Fabricate.build :user }

    it { should be_valid }
    specify { subject.save.should == true }

    describe "uniqueness" do
      before { Fabricate :user }
      it { should validate_uniqueness_of(:email) }
    end
  end

  describe "idiot-proof" do
    subject { Fabricate.build :user }

    it 'should lowercase email' do
      subject.email = 'likeOMG@lolZ.cOm'
      subject.save!
      subject.reload.email.should == 'likeomg@lolz.com'
    end

    # TODO:
    # it 'should validate email format' do
    #   ['foo', 'foo@bar', 'a@b.c'].each do |email|
    #     subject.email = email
    #     subject.should_not be_valid
    #   end
    # end

    # TODO:
    # it 'should strip fields' do
    #   subject.first_name = '  bar '
    #   subject.last_name = '  baz '
    #   subject.email = '  foo@bar.com  '
    #   subject.should be_valid
    #   subject.save!
    #   subject.reload
    #   subject.first_name.should == 'bar'
    #   subject.last_name.should == 'baz'
    #   subject.email.should == 'foo@bar.com'
    # end
  end

  describe "on create" do
    subject { Fabricate.build :user }

    it 'should require a password' do
      ['', '    ', nil].each do |pass|
        subject.password = pass
        subject.should_not be_valid
      end
    end

    it 'should not require password on update' do
      subject.save!
      old_pass = subject.encrypted_password
      subject.password = nil
      subject.should be_valid
      subject.save.should be_true
      subject.reload.encrypted_password.should == old_pass
    end
  end

  # TODO:
  # describe "authentication" do
  #   before do
  #     @login = 'swordfish'
  #     @email = 'sword@fish.com'
  #     @password = 'nightingale'
  #     @user = Fabricate(:user, :email => @email, :password => @password)
  #   end

  #   it { User.authenticate(@login, @password).should == @user }
  #   it { User.authenticate(@login.upcase, @password).should == @user }

  #   it { User.authenticate(@email, @password).should == @user }
  #   it { User.authenticate(@email.upcase, @password).should == @user }

  #   it "should return nil for incorrect login attempts" do
  #     User.authenticate(@login, "bad_password").should be_nil
  #     User.authenticate(@email, "bad_password").should be_nil
  #     User.authenticate("bad_email", "badpass").should be_nil
  #     User.authenticate("", "").should be_nil
  #     User.authenticate(nil, nil).should be_nil
  #   end
  # end

end
