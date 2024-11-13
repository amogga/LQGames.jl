module Plotting
	
	using Plots
	
	export plot_positions_from_iteration

	# TODO: generalize (dependent on position indices)
	function plot_positions_from_iteration(iteration;xlims=nothing,ylims=nothing)
		x, _ = iteration
		posx1, posy1, posx2, posy2, posx3, posy3 = map(pos->getindex.(x,pos),[1,2,5,6,9,10])

		# Plot with optional xlims and ylims
	    plot_args = Dict()
	    if !isnothing(xlims)
	        plot_args[:xlims] = xlims
	    end
	    if !isnothing(ylims)
	        plot_args[:ylims] = ylims
	    end

		plot!(posx1,posy1, plot_args...)
		plot!(posx2,posy2, plot_args...)
		plot!(posx3,posy3, plot_args...)

		gui()
		println("Press Enter to close the plot window...")
		readline()
	end

end