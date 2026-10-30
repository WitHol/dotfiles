local state = {
    left = {},
    right = {},
}

hl.layout.register("double", {
    recalculate = function(ctx)
    end,

    layout_msg = function(ctx, msg)
    end
})

hl.config({
    general = {
        layout = "master"
    }
})

hl.config({
    master = {
        mfact = 0.5
    }
})

