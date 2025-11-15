function loco(){
    gsap.registerPlugin(ScrollTrigger);
    const locoScroll = new LocomotiveScroll({el: document.querySelector("#main"), smooth: true});
    locoScroll.on("scroll", ScrollTrigger.update);
    ScrollTrigger.scrollerProxy("#main", {
        scrollTop(value) {
            return arguments.length ? locoScroll.scrollTo(value, 0, 0) : locoScroll.scroll.instance.scroll.y;
        },
        getBoundingClientRect() {
            return {top: 0, left: 0, width: window.innerWidth, height: window.innerHeight};
        },
        pinType: document.querySelector("#main").style.transform ? "transform" : "fixed"
    });
    ScrollTrigger.addEventListener("refresh", () => locoScroll.update());
    ScrollTrigger.refresh();
}
loco();

var clutter = "";
document.querySelector("#page2>h1").textContent.split("").forEach(function(dets){
    clutter += `<span>${dets}</span>`;
    document.querySelector("#page2>h1").innerHTML = clutter;
});

gsap.to("#page2>h1>span",{
    scrollTrigger:{
        trigger:"#page2>h1>span",
        start:"top bottom",
        scroller:"#main",
        scrub:.5
    },
    stagger:.2,
    color:"#fff"
});

function canvas(){
    const canvas = document.querySelector("#page3>canvas");
    const context = canvas.getContext("2d");
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    window.addEventListener("resize", function () {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        render();
    });
    function files(index) {
        var data = `
        ./frames00061.png
        ./frames00064.png
        ./frames00067.png
        ./frames00070.png
        ./frames00073.png
        ./frames00076.png
        ./frames00079.png
        ./frames00082.png
        ./frames00085.png
        ./frames00088.png
        ./frames00091.png
        ./frames00094.png
        ./frames00097.png
        ./frames00100.png
        ./frames00103.png
        ./frames00106.png
        ./frames00109.png
        ./frames00112.png
        ./frames00115.png
        ./frames00118.png
        ./frames00121.png
        ./frames00124.png
        ./frames00127.png
        ./frames00130.png
        ./frames00133.png
        ./frames00136.png
        ./frames00139.png
        ./frames00142.png
        ./frames00145.png
        ./frames00148.png
        ./frames00151.png
        ./frames00154.png
        ./frames00157.png
        ./frames00160.png
        ./frames00163.png
        ./frames00166.png
        ./frames00169.png
        ./frames00172.png
        ./frames00175.png
        ./frames00178.png
        ./frames00181.png
        ./frames00184.png
        ./frames00187.png
        ./frames00190.png
        ./frames00193.png
        ./frames00196.png
        ./frames00199.png
        ./frames00202.png
        `;
        return data.split("\n")[index];
    }
    const frameCount = 48;
    const images = [];
    const imageSeq = {frame: 1};
    for (let i = 0; i < frameCount; i++) {
        const img = new Image();
        img.src = files(i);
        images.push(img);
    }
    gsap.to(imageSeq, {
        frame: frameCount - 1,
        snap: "frame",
        ease: "none",
        scrollTrigger: {
            scrub: .5,
            trigger: "#page3",
            start: "top top",
            end: "150% top",
            scroller: "#main"
        },
        onUpdate: render
    });
    images[1].onload = render;
    function render() {
        scaleImage(images[imageSeq.frame], context);
    }
    function scaleImage(img, ctx) {
        var canvas = ctx.canvas;
        var hRatio = canvas.width / img.width;
        var vRatio = canvas.height / img.height;
        var ratio = Math.max(hRatio, vRatio);
        var centerShift_x = (canvas.width - img.width * ratio) / 2;
        var centerShift_y = (canvas.height - img.height * ratio) / 2;
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.drawImage(img, 0, 0, img.width, img.height, centerShift_x, centerShift_y, img.width * ratio, img.height * ratio);
    }
    ScrollTrigger.create({
        trigger: "#page3",
        pin: true,
        scroller: "#main",
        start: "top top",
        end: "200% top"
    });
}
canvas();

var clutter = "";
document.querySelector("#page4>h1").textContent.split("").forEach(function(dets){
    clutter += `<span>${dets}</span>`;
    document.querySelector("#page4>h1").innerHTML = clutter;
});

gsap.to("#page4>h1>span",{
    scrollTrigger:{
        trigger:"#page4>h1>span",
        start:"top bottom",
        end:"bottom top",
        scroller:"#main",
        scrub:.5
    },
    stagger:.2,
    color:"#fff"
});

function canvas1(){
    const canvas = document.querySelector("#page5>canvas");
    const context = canvas.getContext("2d");
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    window.addEventListener("resize", function () {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
        render();
    });
    ScrollTrigger.create({
        trigger: "#page5",
        pin: true,
        scroller: "#main",
        start: "top top",
        end: "200% top"
    });
}
canvas1();