module Plotting

	using Plots
	
	export plot_positions_from_iteration,build_position_animation_from_iteration

	# TODO: generalize (dependent on position indices)
	function plot_positions_from_iteration(iteration;xlims=nothing,ylims=nothing)
		p = plot_positions_from_iteration_as_plot(iteration[1]; xlims=xlims, ylims=ylims)
		gui(p)
		println("Press Enter to close the plot window...")
		readline()
	end

	function build_position_animation_from_iteration(iteration; file)
		anim = @animate for i ∈ 1:length(iteration[1])
		    plot_positions_from_iteration_as_plot(iteration[1][1:i])
		end
		gif(anim, file, fps = 15)
	end

	# TODO: generalize (dependent on position indices)
	function plot_positions_from_iteration_as_plot(state_iteration;xlims=nothing,ylims=nothing)
		x = state_iteration
		posx1, posy1, posx2, posy2, posx3, posy3 = map(pos->getindex.(x,pos),[1,2,5,6,9,10])

		# Plot with optional xlims and ylims
	    plot_args = Dict()
	    if !isnothing(xlims)
	        plot_args[:xlims] = xlims
	    end
	    if !isnothing(ylims)
	        plot_args[:ylims] = ylims
	    end

		p = plot(posx1,posy1, plot_args...)
		plot!(posx2,posy2, plot_args...)
		plot!(posx3,posy3, plot_args...)

		return p
	end
end