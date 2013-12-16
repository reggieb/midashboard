

class CompactorTest < ActiveSupport::TestCase

  def test_average
    compactor = Compactor.new([1, 2, 3, 4])
    assert_equal 2.5, compactor.average
  end

  def test_compact_to
    compactor = Compactor.new((1..30).to_a)
    smaller = (1..10).to_a
    compactor.compact_to!(smaller)
    assert_equal(smaller.collect{|n| (n * 3) - 2}, compactor)
  end

  def test_compact_to_with_large_other
    compactor = Compactor.new([1, 2])
    other = [1, 2, 3]
    compactor.compact_to!(other)
    assert_equal([1, 2], compactor)
  end

  def test_compactor_last
    compactor = Compactor.new((1..30).to_a)
    smaller = (1..10).to_a
    compactor.compact_to!(smaller, :last)
    assert_equal(smaller.collect{|n| (n * 3)}, compactor)
  end

  def test_compactor_average
    compactor = Compactor.new([2, 2, 4, 2])
    smaller = [1, 2]
    compactor.compact_to!(smaller, 'average')
    assert_equal([2, 3], compactor)
  end

end
