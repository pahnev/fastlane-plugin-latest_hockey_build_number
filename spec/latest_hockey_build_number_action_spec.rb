describe Fastlane::Actions::LatestHockeyBuildNumberAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The latest_hockey_build_number plugin is working!")

      Fastlane::Actions::LatestHockeyBuildNumberAction.run(nil)
    end
  end
end
