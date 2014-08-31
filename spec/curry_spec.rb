require 'curry'

RSpec.describe 'Proc#curry' do
  # These examples are from http://rubydoc.info/stdlib/core/Proc#curry-instance_method.

  context 'when a proc has three arguments' do
    let(:b) { proc {|x, y, z| (x||0) + (y||0) + (z||0) } }

    specify { expect(b.curry[1][2][3]).to eq 6 }
    specify { expect(b.curry[1, 2][3, 4]).to eq 6 }
    specify { expect(b.curry(5)[1][2][3][4][5]).to eq 6 }
    specify { expect(b.curry(5)[1, 2][3, 4][5]).to eq 6 }
    specify { expect(b.curry(1)[1]).to eq 1 }
  end

  context 'when a proc has three arguments, plus optional arguments' do
    let(:b) { proc {|x, y, z, *w| (x||0) + (y||0) + (z||0) + w.inject(0, &:+) } }

    specify { expect(b.curry[1][2][3]).to eq 6 }
    specify { expect(b.curry[1, 2][3, 4]).to eq 10 }
    specify { expect(b.curry(5)[1][2][3][4][5]).to eq 15 }
    specify { expect(b.curry(5)[1, 2][3, 4][5]).to eq 15 }
    specify { expect(b.curry(1)[1]).to eq 1 }
  end

  context 'when a lambda has three arguments' do
    let(:b) { lambda {|x, y, z| (x||0) + (y||0) + (z||0) } }

    specify { expect(b.curry[1][2][3]).to eq 6 }
    specify { expect { b.curry[1, 2][3, 4] }.to raise_error(ArgumentError, 'wrong number of arguments (4 for 3)') }
    specify { expect { b.curry(5) }.to raise_error(ArgumentError, 'wrong number of arguments (5 for 3)') }
    specify { expect { b.curry(1) }.to raise_error(ArgumentError, 'wrong number of arguments (1 for 3)') }
  end

  context 'when a lambda has three arguments, plus optional arguments' do
    let(:b) { lambda {|x, y, z, *w| (x||0) + (y||0) + (z||0) + w.inject(0, &:+) } }

    specify { expect(b.curry[1][2][3]).to eq 6 }
    specify { expect(b.curry[1, 2][3, 4]).to eq 10 }
    specify { expect(b.curry(5)[1][2][3][4][5]).to eq 15 }
    specify { expect(b.curry(5)[1, 2][3, 4][5]).to eq 15 }
    specify { expect { b.curry(1) }.to raise_error(ArgumentError, 'wrong number of arguments (1 for 3+)') }
  end

  context 'when a proc has no arguments' do
    let(:b) { proc { :foo } }

    specify { expect(b.curry[]).to eq :foo }
  end
end
