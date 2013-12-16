require 'test_helper'

class HashWalkerTest < ActiveSupport::TestCase
  def hash_walker
    hash = {
      one: {
        a: 1,
        b: 2,
        c: 3,
      },
      two: [
        {
          x: [
            {y: [19, 20, 21]},
            {z: {za: 22, zb: 23, zc: 24}}
          ]
        }
      ],
      three: [
        {i: 5, ii: 6, iii: 7},
        {i: 8, iv: 25}
      ],
      four: [
        [9, 10, 11, 14],
        [15]
      ],
      five: [16, 17, 18]
    }
    HashWalker.new(hash)
  end

  def test_array
    assert_equal([16, 17, 18], hash_walker.array('five'))
  end

  def test_values
    assert_equal([1, 2, 3], hash_walker.values('one'))
  end

  def test_array_deep_key
    assert_equal([5, 8], hash_walker.array('three/i'))
  end

  def test_array_deep
    assert_equal([19, 20, 21], hash_walker.array('two/x/y'))
  end

  def test_values_deep
    assert_equal([22, 23, 24], hash_walker.values('two/x/z'))
  end

  def test_deep_single_value
    assert_equal([23], hash_walker.array('two/x/z/zb'))
  end

  def wild_hash
    hash = {
      one: {a: 1, b:2},
      two: {a: 2, b:4},
      three: {a: 10, b: 1}
    }
    HashWalker.new(hash)
  end

  def test_wild_card
    assert_equal([1, 2, 10], wild_hash.array('*/a'))
    assert_equal([2, 4, 1], wild_hash.array('*/b'))
  end

  def hash_array
    array = [
      {a: 1, b:2},
      {a: 2, b:4},
      {a: 10, b: 1}
    ]
    HashWalker.new(array)
  end

  def test_hash_array
    assert_equal([1, 2, 10], hash_array.array('a'))
    assert_equal([2, 4, 1], hash_array.array('b'))
  end
end
