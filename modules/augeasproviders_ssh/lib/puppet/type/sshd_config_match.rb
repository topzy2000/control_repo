# frozen_string_literal: true

# Manages settings in OpenSSH's sshd_config file
#
# Copyright (c) 2015-2020 Raphaël Pinson
# Licensed under the Apache License, Version 2.0

Puppet::Type.newtype(:sshd_config_match) do
  @doc = 'Manages Match groups in an OpenSSH sshd_config file.'

  ensurable do
    defaultvalues

    newvalue(:positioned) do
      current = retrieve
      if current == :absent
        provider.create
      elsif !provider.in_position?
        provider.position!
      end
    end

    def insync?(is)
      return true if should == :positioned && is == :present && provider.in_position?

      super
    end
  end

  newparam(:name) do
    desc 'The default namevar'
  end

  newparam(:condition) do
    isnamevar
    desc 'The condition of the Match group'

    munge do |value|
      if value.is_a? Hash
        # TODO: test this
        value
      else
        value_a = value.split
        Hash[*value_a]
      end
    end
  end

  newparam(:target) do
    isnamevar
    desc 'The file in which to manage the sshd_config_match entry'
  end

  def self.title_patterns
    [
      [
        %r{^(((?:\S*\s+\S*)+)\s+in\s+(\S+))$},
        [
          [:name],
          [:condition],
          [:target],
        ],
      ],
      [
        %r{^(((?:\S*\s+\S*)+))$},
        [
          [:name],
          [:condition],
        ],
      ],
      [
        %r{(.*)},
        [
          [:name],
        ],
      ],
    ]
  end

  newparam(:position) do
    desc 'Where to place the new entry'
    validate do |value|
      raise "Wrong position statement '#{value}'" unless value =~ %r{^(before|after)}
    end

    munge do |value|
      before_s, *path_a = value.split
      {
        before: before_s == 'before',
        match: path_a.join(' '),
      }
    end
  end

  newproperty(:comment) do
    desc 'Text to be stored in a comment immediately above the entry.
    It will be automatically prepended with the name of the variable in order
    for the provider to know whether it controls the comment or not.'
    defaultto { 'created by Puppet' }
  end

  autorequire(:file) do
    self[:target]
  end
end
