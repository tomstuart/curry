class Proc
  remove_method :curry

  def curry(arity = nil)
    number_of_args = self.arity < 0 ? -self.arity - 1 : self.arity
    arity ||= number_of_args

    if lambda?
      too_few_args = arity < number_of_args

      if too_few_args
        raise ArgumentError, "wrong number of arguments (#{arity} for #{number_of_args})"
      end
    end

    proc do |*args|
      if args.length < arity
        proc { |*more_args| call(*args + more_args) }.curry(arity - args.length)
      else
        call(*args)
      end
    end
  end
end
