require 'minitest/autorun'
require 'geometry'
require "bigdecimal"

class IntersectionPointWithTest < Minitest::Test
  include Geometry

  def test_regular_case
    segment1 = Segment.new_by_arrays([0, 0], [2, 2])
    segment2 = Segment.new_by_arrays([0, 2], [2, 0])

    assert_equal Point.new(1, 1), segment1.intersection_point_with(segment2)
  end

  def test_segments_intersect_at_the_endpoint
    segment1 = Segment.new_by_arrays([0, 0], [2, 2])
    segment2 = Segment.new_by_arrays([0, 2], [2, 2])

    assert_equal Point.new(2, 2), segment1.intersection_point_with(segment2)
  end

  def test_big_decimal_segments_intersect_at_the_endpoint
    segment1 = Segment.new_by_arrays([BigDecimal.new("-109.775390625"),
                                      BigDecimal.new("42.734102391081")],
                                     [BigDecimal.new("-91.23046875"),
                                      BigDecimal.new("42.734102391081")])

    segment2 = Segment.new_by_arrays([BigDecimal.new("-91.23046875"),
                                      BigDecimal.new("42.734102391081")],
                                     [BigDecimal.new("-91.23046875"),
                                      BigDecimal.new("34.147272023649")])

    assert_equal Point.new(BigDecimal.new("-91.23046875"),
                           BigDecimal.new("42.734102391081")),
                 segment1.intersection_point_with(segment2)
  end

  def test_segments_do_not_intersect
    segment1 = Segment.new_by_arrays([0, 0], [0, 2])
    segment2 = Segment.new_by_arrays([1, 1], [2, 1])

    assert_raises SegmentsDoNotIntersect do
      segment1.intersection_point_with(segment2)
    end
  end

  def test_segments_are_parallel
    segment1 = Segment.new_by_arrays([0, 0], [2, 2])
    segment2 = Segment.new_by_arrays([1, 0], [3, 2])

    assert_raises SegmentsDoNotIntersect do
      segment1.intersection_point_with(segment2)
    end
  end

  def test_segments_overlap
    segment1 = Segment.new_by_arrays([0, 0], [2, 2])
    segment2 = Segment.new_by_arrays([1, 1], [3, 3])

    assert_raises SegmentsOverlap do
      segment1.intersection_point_with(segment2)
    end
  end

  def test_segments_parallel_and_have_common_endpoint
    skip 'Not implemented yet'

    segment1 = Segment.new_by_arrays([0, 0], [1, 0])
    segment2 = Segment.new_by_arrays([1, 0], [2, 0])

    assert_equal Point.new(0, 1), segment1.intersection_point_with(segment2)
  end
end
