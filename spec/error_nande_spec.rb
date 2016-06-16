describe ErrorNande do
  describe ".nande" do
    subject { ErrorNande.nande(ex) }

    context "toplevel" do
      let(:ex) { ArgumentError.new("foo") }
      it { is_expected.to eq "#<ArgumentError: foo> at (toplevel)" }
    end

    context "with backtrace" do
      let(:ex) do
        ex = NameError.new("bar baz")
        allow(ex).to receive(:backtrace).and_return(["/path/to/file1.rb:42:in `func1'", "/path/to/file2.rb:42:in `func2'"])
        ex
      end
      it { is_expected.to eq "#<NameError: bar baz> at /path/to/file1.rb:42:in `func1'" }
    end

    context "with causes" do
      let(:ex) do
        ex1 = ArgumentError.new("ex 1")
        allow(ex1).to receive(:backtrace).and_return(["/path/to/file1.rb:42:in `func1'"])
        ex2 = NameError.new("ex 2")
        allow(ex2).to receive(:backtrace).and_return(["/path/to/file2.rb:42:in `func2'"])
        ex3 = TypeError.new("ex 3")
        allow(ex3).to receive(:backtrace).and_return(["/path/to/file3.rb:42:in `func3'"])

        allow(ex1).to receive(:cause).and_return(ex2)
        allow(ex2).to receive(:cause).and_return(ex3)

        ex1
      end
      it { is_expected.to eq "#<ArgumentError: ex 1> at /path/to/file1.rb:42:in `func1' (cause #<NameError: ex 2> at /path/to/file2.rb:42:in `func2') (cause #<TypeError: ex 3> at /path/to/file3.rb:42:in `func3')" }
    end

    describe "with Rails.backtrace_cleaner" do
      before do
        begin
          require "rails"
          allow(::Rails).to receive(:root).and_return('/path/to/rails')
        rescue StandardError, LoadError => e
          skip "Cannot run spec with Rails.backtrace_cleaner: #{e.inspect}"
        end
      end

      context "toplevel" do
        let(:ex) { ArgumentError.new("foo") }
        it { is_expected.to eq "#<ArgumentError: foo> at (toplevel)" }
      end

      context "with backtrace" do
        let(:ex) do
          ex = NameError.new("bar baz")
          allow(ex).to receive(:backtrace).and_return(["/path/to/file1.rb:42:in `func1'", "/path/to/file2.rb:142:in `func2'"])
          ex
        end
        it { is_expected.to eq "#<NameError: bar baz> at /path/to/file1.rb:42:in `func1'" }
      end

      context "with backtrace, inside Rails.root" do
        let(:ex) do
          ex = TypeError.new("baz qux")
          allow(ex).to receive(:backtrace).and_return(["#{Rails.root}/file11.rb:42:in `func11'", "#{Rails.root}/file12.rb:142:in `func12'"])
          ex
        end
        it { is_expected.to eq "#<TypeError: baz qux> at file11.rb:42:in `func11'" }
      end
    end
  end
end
