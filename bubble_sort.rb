def bubble_sort(arr)
  last_idx = arr.length - 1
  while last_idx.positive?
    swaped = false
    0.upto(last_idx - 1).each do |idx|
      if arr[idx] > arr[idx + 1]
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
        swaped = true
      end
    end
    break unless swaped

    last_idx -= 1
  end
  arr
end

bubble_sort([4, 3, 78, 2, 0, 2])
# => [0,2,2,3,4,78]
