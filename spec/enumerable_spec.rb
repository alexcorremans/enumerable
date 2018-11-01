require './enumerable'

describe Enumerable do
    # test data
=begin
    before(:each) do
        test_arr = [1,2,3,4,5]
        result = []
        test_hash = {
            one: 1,
            two: 2,
            three: 3,
            four: 4,
            five: 5
        }
        result_hash = {}  
    end
=end

    let(:test_arr) { [1,2,3,4,5] }
    let(:result) { [] }
    let(:test_hash) { {
        one: 1,
        two: 2,
        three: 3,
        four: 4,
        five: 5
    } }
    let(:result_hash) {{}}

    describe "#my_each" do       
        it "calls the given block for each element" do
            test_arr.my_each { |x| result << x }
            expect(result).to eql(test_arr)
        end

        it "returns the array itself" do
            expect(test_arr.my_each { |x| result << x }).to eql(test_arr)
        end

        it "returns an Enumerator if no block given" do
            expect(test_arr.my_each).to be_an Enumerator
        end
    end

    describe "#my_each_with_index" do
        it "calls the given block for each element and its index" do
            test_arr.my_each_with_index { |x,i| result << (x + i) }
            expect(result).to eql([1,3,5,7,9])
        end
        
        it "returns the array itself" do
            expect(test_arr.my_each_with_index { |x,i| result << (x + i) }).to eql(test_arr)
        end

        it "returns an Enumerator if no block given" do
            expect(test_arr.my_each_with_index).to be_an Enumerator
        end
    end

    describe "#my_select" do
        it "returns an array containing all the elements of an array for which the given block returns a true value" do
            result = test_arr.select { |x| x > 3 }
            expect(result).to eql([4,5])
        end
        
        it "returns a hash containing all the key-value pairs of a hash for which the given block returns a true value" do
            result_hash = test_hash.select { |k,v| v > 3 }
            expect(result_hash).to eql({ four: 4, five: 5 })
        end

        it "returns an Enumerator if no block given" do
            expect(test_arr.my_select).to be_an Enumerator
        end
    end

    describe "#my_all?" do
        it "returns true if the block never returns false or nil" do
            result = test_arr.my_all? { |x| x > 0 }
            expect(result).to be true
        end

        it "returns true if no block given when none of the elements are false or nil" do
            result = test_arr.my_all?
            expect(result).to be true
        end
    end

    describe "#my_any?" do
        it "returns true if the block ever returns a value other than false or nil" do
            result = test_arr.my_any? { |x| x > 4 }
            expect(result).to be true
        end

        it "returns true if no block given when at least one of the elements is not false or nil" do
            result = [nil,nil,1].my_any?
            expect(result).to be true
        end
    end

    describe "#my_none?" do
        it "returns true if the block never returns true for all elements" do
            result = test_arr.my_none? { |x| x > 5 }
            expect(result).to be true
        end

        it "returns true if no block given if none of the elements is true" do
            result = [].my_none?
            expect(result).to be true
        end
    end

    describe "#my_count" do
        it "returns the number of elements if no arguments and no block given" do
            expect(test_arr.count).to eql(5)
        end

        it "returns the number of elements equal to the argument if an argument given" do
            expect(test_arr.count(2)).to eql(1)
        end

        it "returns the number of elements yielding a true value if a block given" do
            result = test_arr.count { |x| x > 2 }
            expect(result).to eql(3)
        end
    end
end