require("smear_cursor").setup({
    opts = {
        smear_insert_mode = true,
        time_interval = 1,
        stiffness = 0.8,
        trailing_stiffness = 0.3,
        stiffness_insert_mode = 0.7,
        damping = 0.95
    },
})
