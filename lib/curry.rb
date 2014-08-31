class Proc
  remove_method :curry

  def curry(arity = nil)
    arity ||= self.arity < 0 ? -self.arity - 1 : self.arity

    proc do |*args|
      if args.length < arity
        proc { |*more_args| call(*args + more_args) }.curry(arity - args.length)
      else
        call(*args)
      end
    end
  end
end
