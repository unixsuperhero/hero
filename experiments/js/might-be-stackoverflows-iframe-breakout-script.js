;
(function(f) {
    var a = window.jQuery, c = f.h, h = "&utm_source=" + location.hostname + "&utm_medium=ad&utm_campaign=", b = encodeURIComponent, g = function(j) {
        var k = [];
        for (var i in j) {
            if (j.hasOwnProperty(i) && j[i]) {
                k.push(b(i) + "=" + b(j[i]))
            }
        }
        return k.join("&")
    }, e = function(k) {
        var j = a(this), i = j.data(), l = "//" + c + "/j/ct", m = g(a.extend({utm: h + k.data.utm,an: f.an}, i));
        this.href = l + "?" + m
    }, d = function(k, j) {
        var i = (j.cl || []).join(" ");
        a("#" + k).addClass(i).html(j.cn).on("mousedown", "a", j, e)
    };
    if (!window.addStyle) {
        window.addStyle = function(k) {
            var j = "stylesheet";
            var i = "css";
            a("<link>").attr({type: "text/" + i,rel: j,href: k}).appendTo("head")
        }
    }
    a.each(f.st, function(j, k) {
        window.addStyle(k)
    });
    a.each(f.cr, d)
}).apply(null, [{"st": ["//cdn.sstatic.net/clc/styles/jobs.min.css?v=f1ac50caf215"],"cr": {"hireme": {"cl": ["tag-themed", "rails", "tagged"],"utm": "jobs-small-tag-themed-rails","cn": "<a href=\"//careers.stackoverflow.com/jobs/tag/ruby-on-rails?a=81rtm\" target=\"_blank\" data-la=\"81rtm\" data-hf=\"h\" class=\"top\"> <span>Want a <span class=\"header-tag\">rails</span> job?</span></a><ul class=\"jobs\"><li><a data-cid=\"169136\" data-la=\"rMA5dOrpIkh\" href=\"//careers.stackoverflow.com/jobs/82844/full-stack-engineer-greenhouse-software\" target=\"_blank\" title=\"Full Stack Engineer at Greenhouse Software. Click to learn more.\">Full Stack Engineer<br /><div class=\"company\">Greenhouse Software</div><div class=\"location\" title=\"New York, NY\">New York, NY</div><span class=\"post-tag\">javascript</span><span class=\"post-tag highlight\">ruby-on-rails</span></a></li><li><a data-cid=\"168897\" data-la=\"rHsjj5UrXnY\" href=\"//careers.stackoverflow.com/jobs/82598/lead-developer-ruby-full-time-remote-hello-labs-bequick\" target=\"_blank\" title=\"Lead Developer, Ruby (Full Time Remote) at Hello Labs | BeQuick. Click to learn more.\">Lead Developer, Ruby (Full Time Remote)<br /><div class=\"company\">Hello Labs | BeQuick</div><div class=\"location\" title=\"Palm Beach Gardens, FL / remote\">Palm Beach Gardens, FL / remote</div><span class=\"post-tag highlight\">ruby-on-rails</span><span class=\"post-tag\">ember.js</span></a></li></ul><img class=\"impression\" src=\"//clc.stackoverflow.com/j/i?an=Y25r4t7jZHXJgwEImJgZmFgFGZgY2HlAPIYNU5gYSjMnRrQGPbFnA0swMgARTyFQIYswUAmLIJBgZgLpPTiZicHcQDC86Mgre1aIWhuQWktmZmRlQUpXOwu3LqpNmQcA\" style=\"display:none;\" /><img class=\"impression\" src=\"//careers.stackoverflow.com/gethired/i/rMA5dOrpIkh-rHsjj5UrXnY-81rtm\" style=\"display:none;\" />"}},"az": [],"h": "clc.stackoverflow.com","an": "Y25r4t7jZHXJgwEImJgZmFgFGZgY2HlAPIYNU5gYSjMnRrQGPbFnA0swMgARTyFQIYswUAmLIJBgZgLpPTiZicHcQDC86Mgre1aIWhuQWktmZmRlQUpXOwu3LqpNmQcA"}]);
