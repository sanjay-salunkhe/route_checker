RSpec.describe PrintResult do
	describe '#call' do
		it 'is expected to print result' do
			uninitilzed_contant = {uninitilzed_contant: [{verb: 'GET', route: '/test', controller: 'tests_controller'}]}
			expect(PrintResult).to receive(:print_uninitialized_controllers)

			PrintResult.call(uninitilzed_contant)
		end
	end
end