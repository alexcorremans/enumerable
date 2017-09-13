module Enumerable

  def my_each
    return self.to_enum(:my_each) unless block_given?
    for x in self
      yield(x)
    end
    self
  end

  def my_each_with_index
    return self.to_enum(:my_each_with_index) unless block_given?
    i = 0
    for x in self
      yield(x, i)
      i += 1
    end
    self
  end

  def my_select
    return self.to_enum(:my_select) unless block_given?
    if self.is_a?(Hash)
      selection = {}
      for k, v in self
        selection[k] = v if yield(k,v)
      end
    else
      selection = []
      for x in self
        selection.push(x) if yield(x)
      end
    end
    selection
  end

  def my_all?
    count = 0
    if block_given?
      for x in self
        count +=1 if yield(x)
      end
    else
      for x in self
        count += 1 unless (x.nil? or x == false)
      end
    end
    if count == self.size
      return true
    else
      return false
    end
  end

  def my_any?
    any = false
    if block_given?
      for x in self
        if yield(x)
          any = true
          break
        end
      end
    else
      for x in self
        if !(x == nil or x == false)
          any = true
          puts any
          break
        end
      end
    end
    any
  end

  def my_none?
    count = 0
    if block_given?
      for x in self
        count +=1 if yield(x)
      end
    else
      for x in self
        count += 1 if x
      end
    end
    if count == 0
      return true
    else
      return false
    end
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      for x in self
        count += 1 if yield(x)
      end
    elsif arg != nil
      for x in self
        count += 1 if x == arg
      end
    else
      for x in self
        count += 1
      end
    end
    count
  end

  def my_map(proc=nil)
    return self.to_enum(:my_map) unless (proc or block_given?)
    array = []
    if block_given?
      for x in self
        array.push(yield(x))
      end
    else
      for x in self
        array.push(proc.call(x))
      end
    end
    array
  end

  def my_inject(arg1=nil, arg2=nil)
    if block_given?
      if arg1 != nil
        memo = arg1
        for x in self
          memo = yield(memo, x)
        end
      else
        memo = self[0]
        for x in self.drop(1)
          memo = yield(memo, x)
        end
      end

    elsif arg1.is_a?(Symbol) or arg1.is_a?(String)
      if arg2 != nil
        memo = arg2
        for x in self
          memo = memo.send(arg1.to_sym,x)
        end
      else
        memo = self[0]
        for x in self.drop(1)
          memo = memo.send(arg1.to_sym,x)
        end
      end

    elsif arg2.is_a?(Symbol) or arg2.is_a?(String)
      if arg1 != nil
        memo = arg1
        for x in self
          memo = memo.send(arg2.to_sym,x)
        end
      else
        memo = self[0]
        for x in self.drop(1)
          memo = memo.send(arg2.to_sym,x)
        end
      end

    else
      if arg1 != nil
        raise TypeError, "#{arg2} is not a symbol nor a string"
        exit
      else
        raise TypeError, "#{arg1} is not a symbol nor a string"
        exit
      end
    end
    memo
  end
end

def multiply_els array
  array.my_inject(:*)
end
