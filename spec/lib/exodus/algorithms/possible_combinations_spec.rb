require 'spec_helper'

describe Exodus::Algorithms::PossibleCombinations do
  describe "#initialize" do
    let(:gems_position) { { '1' => 2, '2' => 4 } }
    let(:lib) { Exodus::Algorithms::PossibleCombinations.new(gems_position) }

    it "should added g_p to instance variable"  do
      expect(lib.g_p).to eq({ 1 => 2, 2 => 4 })
    end
  end

  describe '#perform' do
    context "not have combinations" do
      let(:gems_positions_without_combinations) do
        [
          {"0"=>5, "1"=>4, "2"=>6, "3"=>2, "4"=>0, "5"=>4, "6"=>6, "7"=>1, "8"=>6, "9"=>2, "10"=>5, "11"=>1, "12"=>4, "13"=>6, "14"=>5, "15"=>3, "16"=>1, "17"=>1, "18"=>6, "19"=>0, "20"=>1, "21"=>2, "22"=>0, "23"=>2, "24"=>6, "25"=>4, "26"=>4, "27"=>0, "28"=>2, "29"=>4, "30"=>5, "31"=>2, "32"=>2, "33"=>5, "34"=>2, "35"=>5, "36"=>1, "37"=>4, "38"=>3, "39"=>4, "40"=>5, "41"=>4, "42"=>0, "43"=>1, "44"=>6, "45"=>0, "46"=>0, "47"=>5, "48"=>6, "49"=>0, "50"=>4, "51"=>3, "52"=>4, "53"=>0, "54"=>4, "55"=>6, "56"=>0, "57"=>5, "58"=>1, "59"=>0, "60"=>5, "61"=>2, "62"=>1, "63"=>4},
          {"0"=>5, "1"=>4, "2"=>6, "3"=>2, "4"=>0, "5"=>6, "6"=>6, "7"=>1, "8"=>6, "9"=>2, "10"=>5, "11"=>1, "12"=>4, "13"=>6, "14"=>5, "15"=>1, "16"=>3, "17"=>1, "18"=>6, "19"=>0, "20"=>1, "21"=>2, "22"=>0, "23"=>2, "24"=>6, "25"=>4, "26"=>4, "27"=>0, "28"=>2, "29"=>4, "30"=>5, "31"=>2, "32"=>2, "33"=>5, "34"=>2, "35"=>5, "36"=>1, "37"=>4, "38"=>3, "39"=>4, "40"=>5, "41"=>4, "42"=>0, "43"=>1, "44"=>6, "45"=>0, "46"=>0, "47"=>5, "48"=>6, "49"=>0, "50"=>4, "51"=>3, "52"=>4, "53"=>0, "54"=>4, "55"=>6, "56"=>0, "57"=>5, "58"=>1, "59"=>0, "60"=>5, "61"=>2, "62"=>1, "63"=>4}
        ]
      end

      it "should return false for every gems_position" do
        gems_positions_without_combinations.each do |gems_position|
          expect(Exodus::Algorithms::PossibleCombinations.new(gems_position).perform).to be_falsey
        end
      end
    end

    context "have combinations" do
      let(:gems_positions_with_combinations) do
        [
          {"0"=>5, "1"=>4, "2"=>6, "3"=>2, "4"=>0, "5"=>4, "6"=>6, "7"=>1, "8"=>6, "9"=>6, "10"=>5, "11"=>1, "12"=>4, "13"=>6, "14"=>5, "15"=>3, "16"=>1, "17"=>1, "18"=>6, "19"=>0, "20"=>1, "21"=>2, "22"=>0, "23"=>2, "24"=>6, "25"=>4, "26"=>4, "27"=>0, "28"=>2, "29"=>4, "30"=>5, "31"=>2, "32"=>2, "33"=>5, "34"=>2, "35"=>5, "36"=>1, "37"=>4, "38"=>3, "39"=>4, "40"=>5, "41"=>4, "42"=>0, "43"=>1, "44"=>6, "45"=>0, "46"=>0, "47"=>5, "48"=>6, "49"=>0, "50"=>4, "51"=>3, "52"=>4, "53"=>0, "54"=>4, "55"=>6, "56"=>0, "57"=>5, "58"=>1, "59"=>0, "60"=>5, "61"=>2, "62"=>1, "63"=>4},
          {"0"=>5, "1"=>4, "2"=>6, "3"=>2, "4"=>0, "5"=>4, "6"=>6, "7"=>1, "8"=>6, "9"=>2, "10"=>5, "11"=>1, "12"=>4, "13"=>6, "14"=>2, "15"=>3, "16"=>1, "17"=>1, "18"=>6, "19"=>0, "20"=>1, "21"=>2, "22"=>0, "23"=>2, "24"=>6, "25"=>4, "26"=>4, "27"=>0, "28"=>2, "29"=>4, "30"=>5, "31"=>2, "32"=>2, "33"=>5, "34"=>2, "35"=>5, "36"=>1, "37"=>4, "38"=>3, "39"=>4, "40"=>5, "41"=>4, "42"=>0, "43"=>1, "44"=>6, "45"=>0, "46"=>0, "47"=>5, "48"=>6, "49"=>0, "50"=>4, "51"=>3, "52"=>4, "53"=>0, "54"=>4, "55"=>6, "56"=>0, "57"=>5, "58"=>1, "59"=>0, "60"=>5, "61"=>2, "62"=>1, "63"=>4},
          {"0"=>5, "1"=>4, "2"=>6, "3"=>2, "4"=>0, "5"=>4, "6"=>6, "7"=>1, "8"=>6, "9"=>2, "10"=>5, "11"=>1, "12"=>4, "13"=>6, "14"=>5, "15"=>3, "16"=>1, "17"=>1, "18"=>6, "19"=>2, "20"=>1, "21"=>2, "22"=>0, "23"=>2, "24"=>6, "25"=>4, "26"=>4, "27"=>0, "28"=>2, "29"=>4, "30"=>5, "31"=>2, "32"=>2, "33"=>5, "34"=>2, "35"=>5, "36"=>1, "37"=>4, "38"=>3, "39"=>4, "40"=>5, "41"=>4, "42"=>0, "43"=>1, "44"=>6, "45"=>0, "46"=>0, "47"=>5, "48"=>6, "49"=>0, "50"=>4, "51"=>3, "52"=>4, "53"=>0, "54"=>4, "55"=>6, "56"=>0, "57"=>5, "58"=>1, "59"=>0, "60"=>5, "61"=>2, "62"=>1, "63"=>4}
        ]
      end

      it "should return true for every gems_position" do
        gems_positions_with_combinations.each do |gems_position|
          expect(Exodus::Algorithms::PossibleCombinations.new(gems_position).perform).to be_truthy
        end
      end
    end
  end
end
