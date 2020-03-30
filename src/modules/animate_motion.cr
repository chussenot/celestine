module Celestine::Modules::Animate::Motion
  @animate_motion_tags = String::Builder.new
  @tags = ""

  def animate_motion_tags
    @tags = @animate_motion_tags.to_s if @tags.empty?
    @tags
  end

  def animate_motion(&block : Proc(Celestine::Animate::Motion, Nil))
    animate = Celestine::Animate::Motion.new
    yield animate
    options = [] of String
    unless animate.mpath.empty?
      options << %Q[path="#{animate.mpath}"]
      options << %Q[attributeType="XML"]
      options << %Q[repeatCount="#{animate.repeat_count}"]         if animate.repeat_count
      options << %Q[repeatDur="#{animate.repeat_duration}"]        if animate.repeat_duration
      options << %Q[dur="#{animate.duration}"]                     if animate.duration
      options << %Q[values="#{animate.values.join(";")}"]          unless animate.values.empty?
      options << %Q[from="#{animate.from}"]                        if animate.from
      options << %Q[to="#{animate.to}"]                            if animate.to
      options << %Q[by="#{animate.by}"]                            if animate.by
      options << %Q[keyTimes="#{animate.key_times.join(";")}"]     unless animate.key_times.empty?
      options << %Q[keyPoints="#{animate.key_points.join(";")}"]   unless animate.key_points.empty?
      options << %Q[keySplines="#{animate.key_splines.join(";")}"] unless animate.key_splines.empty?
      options << %Q[min="#{animate.min }"]                         if animate.min
      options << %Q[min="#{animate.max }"]                         if animate.max
      options << %Q[accumulate="sum"]                              if animate.accumulate?
      options << %Q[additive="sum"]                                if animate.additive?
      options << %Q[fill="freeze"]                                 if animate.freeze?

      if animate.mpath =~ /^#/
        @animate_motion_tags << %Q[<animateMotion #{options.join(" ")}>]
        @animate_motion_tags << %Q[<mpath xlink:href="#{animate.mpath}"/>]
        @animate_motion_tags << %Q[</animateMotion>]

      else
        @animate_motion_tags << %Q[<animateMotion #{options.join(" ")} />]
      end
    end
  end
end