# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Case, type: :model do
  subject { build_stubbed :case }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a kicker' do
    subject.kicker = nil
    expect(subject).to_not be_valid
  end

  it 'is generates a slug from the kicker if needed' do
    subject.slug = nil
    expect(subject).to be_valid
    expect(subject.slug).not_to be_nil
  end

  it 'is not valid with an invalid slug' do
    subject.slug = 'asdf asdf'
    expect(subject).to_not be_valid

    subject.slug = 'asdf_asdf'
    expect(subject).to_not be_valid

    subject.slug = 'asdf/asdf'
    expect(subject).to_not be_valid

    subject.slug = 'ASDF-ASDF'
    expect(subject).to_not be_valid
  end

  context 'in translation' do
    after :each do
      I18n.locale = :en
    end

    it 'keeps both languages’ details' do
      subject.title = 'Something'
      I18n.locale = :fr
      subject.title = 'Quelque chose'
      I18n.locale = :en
      expect(subject.title).to eq 'Something'
    end

    it 'knows what other languages it’s available in' do
      subject.title = 'Something'
      I18n.locale = :fr
      subject.title = 'Quelque chose'
      expect(subject.other_available_locales).to eq %w[en]
    end
  end

  it 'can have many editors' do
    subject.editors.build attributes_for(:reader)
    subject.editors.build attributes_for(:reader)
    expect(subject.editors.length).to eq 2
  end
end
